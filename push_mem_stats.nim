# push_mem_stats: Collect system memory statistics and push to Graphite via
# plaintext protocol.
#
import std/[net, os, strformat, strutils]
import times

let memFields = ["MemTotal:", "MemFree:", "Buffers:", "Cached:"]

var appendText = ""
var memTotal = 0f
var memUsed = 0f
let time = now().toTime().toUnix()
let uuid = getEnv("BALENA_DEVICE_UUID")[0..6]

for l in "/proc/meminfo".lines:
   let fields = l.splitWhitespace()
   if memFields.contains(fields[0]):
      let tag = toLower(fields[0][0 .. ^2])
      let value = fields[1].parseInt() / 1024
      appendText = appendText & &"mem.system.{tag}.{uuid} {value:.1f} {time}\n"
      if fields[0] == "MemTotal:":
         memTotal = value
      else:
         memUsed += value
appendText = appendText & &"mem.system.used.{uuid} {memTotal - memUsed:.1f} {time}"
#echo(appendText)

let socket = newSocket()
let server = "192.168.1.126"
#let server = "localhost"
try:
   socket.connect(server, Port(2003))
   socket.send(appendText)
finally:
   socket.close()
