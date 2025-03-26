# volatility2

This image has created by [Mijux](https://mijux.github.io) to access easily to volatility2 without installing python2.7 and its dependencies.

# Specification

- 🔐 Using recent version of Alpine image to benefit latest security patch
- 📚 contains [volatility2](https://github.com/volatilityfoundation/volatility) and all plugins from [community](https://github.com/volatilityfoundation/community)
- 🚀 Easy to use !

# Usage

## From CLI

```bash
docker run --rm -it -v <your_dir>:/forensic/ mijuxdev/volatility2:latest
```
<your_dir> : The directory that contains your memory image, for example you can use "./"

## Docker Compose

```bash
---
services:
  volatility2:
    image: mijuxdev/volatility2:latest
    container_name: my_instance_volatility2
    restart: never
    volumes:
      - ./<your_dir>:/forensic/
```
<your_dir> : The directory that contains your memory image file, for example you can use "./"

Then use docker exec : `docker exec -it my_instance_volatility2 bash`


## Advanced

This section covers advanced usage of volatility2.

### Profiles

Volatility2 is using profiles to parsed memory image file. Volatility2 supports numerous profiles for Windows machines by default. However, profiles for Linux and Mac OS must be added manually...
This image contains 3 custom endpoints to add your profiles :
- /custom_overlays/linux/
- /custom_overlays/mac/
- /custom_overlays/windows/

You have to add a new volume mapping like this `-v <your_custom_linux_overlays_dir>:/custom_overlays/linux/` and it is the same for windows and mac profiles. 

### Plugins

This image contains all plugins from [community](https://github.com/volatilityfoundation/community). To use them you have to specify the following parameter in you volatility command : `--plugins=/home/finder/community/` and it will load all plugins inside this directory. For further information, I invite you to read their README, which explains the specific features. 

# Tag versionning

This repository use the same tags as alpine versionning. If you want use the latest version of alpine, you can use **latest** tag and if you want use a specific version of alpine, use its tag. (example if you want Alpine 3.21.3, use **3.21.3** as tag for this repository.)

# Contact

If you have any suggestions for improvement or questions about the image, you can contact me by e-mail [here](https://mijux.github.io).
