# Photo Gallery

## About

**This is a basic photo gallery web site.**

## Install

##### Requirements (and how to install them on **Ubuntu 16.04**)

- **git**
```shell
$ sudo apt-get update
$ sudo apt-get install git
```
- **Docker**
```shell
$ sudo apt-get update
$ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
$ sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
$ sudo apt-get update
$ sudo apt-get install -y docker-engine
```
Verify if it is working:
```shell
$ sudo systemctl status docker
```

- **docker-compose**
```
$ sudo apt-get update
$ sudo apt-get -y install python-pip
$ sudo pip install docker-compose
```

- **Make**
```
$ sudo apt-get update
$ sudo apt-get install make
```

##### Clone this repository
```
$ git clone https://github.com/vdbalbom/photogallery.git
```

##### Get into the project file
```
$ cd /photogallery
```

##### Get inside the container and configure admin
```
$ make inside-container
$ rails c
$ Admin.create(login: "admin", password: "admin", site_title: "Photo Gallery")
$ exit
$ exit
```

## Test
```
$ make test-photogallery
```

## Run

##### To run
```
$ make run
```

### or

##### To run detached
```
$ make run-detached
```

## Info

- Run on **port 80**.
- To admin login go to **/admin**.
- To contributor login go to **/login**.
- By default installation admin has **login: admin** and **password: admin**.

#### More info

1. There is an admin which can create/delete contributors, change site's name and description, and change its own settings: login and password.
2. Contributors can create/edit/delete its own photos and can change its settings (name, email, description, facebook, instagram and tumblr links, profile picture, login and password).
3. Photos have title, image, optional description and optional tags.
4. It is possible to access gallery filtered by:
  - all contributors and all tags;
  - a specific contributor and all tags;
  - all contributors and a specific tag;
  - a specific contributor and a specific tag
