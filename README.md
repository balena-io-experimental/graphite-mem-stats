Collects system memory stats like Supervisor.

Supervisor / systeminformation for Used:  MemTotal - (MemFree + Buffers + Cached),
where these values are retrieved from `/proc/meminfo`. See Supervisor [calculation](https://github.com/balena-os/balena-supervisor/blob/3e1b1b0be1105d29296914481d866bd942d33eb9/src/lib/system-info.ts#L59) and systeminformation [calculation](https://github.com/sebhildebrandt/systeminformation/blob/5a2bb71c214c01fa02586ae6544ae8380e93f51c/lib/memory.js#L168).

