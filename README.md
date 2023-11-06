# Dead Neurons

![Brains](/src/assets/images/brain-bg.png)

Hello world! This is the repo for my personal website.

## Docs

Everything from a fresh Ubuntu 22.04.

Install chicken https://code.call-cc.org/.

```
sudo apt install chicken-bin
```

Install python3, pip and jupyter.

```
sudo apt install python3
sudo apt install python3-pip
pip3 install jupyterlab
```

Add local pip packages to path.

```
nano ~/.bashrc

# Add the following line and save
export PATH="$HOME/.local/bin:$PATH"
```

Install node and gulp.

```
sudo apt install nodejs
sudo apt install npm
sudo npm install --global gulp-cli
```

Install npm packages.

```
cd src
npm install
```

Install chicken packages.

```
# Run shell commands for compilation
sudo chicken-install shell

# Scheme style html templates
sudo chicken-install sxml-serializer

# List processing
sudo chicken-install srfi-1

# Time and Date
sudo chicken-install srfi-19
```

Compile main and run build.

```
csc main.scm
./main
```

Start local web server

```
cd build
python3 -m http.server
```

Visit localhost:8000
