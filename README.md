### Install LunarVim inside docker

Use the following bash command to install LunarVim and dependencies:
```bash
docker build --build-arg USER_ID=$(id -u username) --build-arg GROUP_ID=$(id -g username) --build-arg USERNAME=username -t container_name base_os/
```

Or in fish:
```fish
docker build --build-arg USER_ID=(id -u username) --build-arg GROUP_ID=(id -g username) --build-arg USERNAME=username -t lvim base_os/
```

This command will install LunarVim inside a base OS image of `base_os`, create and use user `username` (exists in host system) inside Docker container named `container_name`.

To run container with mounted folder (for editing ofc), use the following command:
```bash
docker run -it --volume /path/to/host/folder:/path/to/mount/container/folder container_name
```

That's it!
