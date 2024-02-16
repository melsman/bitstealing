## Artifact for paper on Double-Ended Bit-Stealing

Running the measurements assume that you are on an x86_64 system with MLton 2021 and MLKit (> v4.7.8) installed. Moreover, the following repositories should be checked out at `~/gits/`:

```
cd
mkdir gits
cd ~/gits
git clone https://github.com/melsman/mlkit.git
git clone https://github.com/melsman/mlkit-bench.git 
git clone https://github.com/diku-dk/smlpkg.git
```

### Preparation

The following commands will install `smlpkg` into `~/.local` and compile MLKit, the MLKit Bench tool, and the MLKit Press tool:

```
cd
mkdir ~/.local
cd ~/gits/smlpkg && make && prefix=~/.local make install 
cd ~/gits/mlkit && ./autobuild && ./configure --with-compiler=mlkit && make && make mlkit_basislibs && make smltojs && make smltojs_basislibs
cd ~/gits/mlkit-bench && make && cd src/charting && make && cd ../press && make
```

