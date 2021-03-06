include init.mk

all: system tools scientific

# ============================================================================
# -- System
# ============================================================================
system: portage-dirs world-use sudo netselect lsof nfs-utils

portage-dirs:
	mkdir -p /etc/portage/package.keywords
	mkdir -p /etc/portage/package.use
	mkdir -p /etc/portage/package.mask
	mkdir -p /etc/portage/package.unmask

world-use: portage-dirs
	echo 'dev-libs/libxml2 python' > /etc/portage/package.use/libxml2 
	echo 'x11-libs/libdrm libkms' > /etc/portage/package.use/libdrm 
	echo 'x11-libs/pango X' > /etc/portage/package.use/pango

sudo:
	emerge -uDN sudo

netselect:
	emerge -uDN netselect

lsof:
	emerge -uDN lsof

cpufrequtils:
	emerge -uDN sys-power/cpufrequtils

nfs-utils:
	emerge -uDN net-fs/nfs-utils

# ============================================================================
# -- Tools
# ============================================================================
tools: zsh vim tmux screen htop keychain gparallel pip python27 tig terminator

zsh:
	emerge -uDN zsh

vim: portage-dirs
	echo "app-editors/vim bash-completion vim-pager python ruby" > /etc/portage/package.use/vim
	emerge -uDN vim{,-core}

tmux:
	emerge -uDN tmux

screen:
	emerge -uDN screen

htop:
	emerge -uDN htop

keychain:
	emerge -uDN keychain

python27:
	echo "dev-lang/python sqlite" > /etc/portage/package.use/python
	eselect python set python2.7
	python-updater
	emerge --update --newuse --deep --with-bdeps=y @world
	emerge --depclean
	revdep-rebuild
	eselect python set python2.7 || exit 0

gparallel:
	echo "sys-process/parallel ~amd64" > /etc/portage/package.keywords/gparallel
	emerge -uDN sys-process/parallel

pip: python27
	echo 'dev-python/pip ~amd64' > /etc/portage/package.keywords/pip
	emerge -uDN dev-python/pip

tig:
	emerge -uDN tig

terminator:
	echo 'x11-libs/vte python' > /etc/portage/package.use/terminator
	emerge -uDN x11-terms/terminator

# ============================================================================
# -- Scientific
# ============================================================================
scientific: atlas numpy scipy ipython joblib scikits.learn

atlas: cpufrequtils
	cpufreq-set -g performance
	# -- blas
	emerge -uDN cblas blas
	emerge -uDN blas-atlas
	eselect blas set atlas-threads || exit 0
	eselect cblas set atlas-threads || exit 0
	# -- lapack
	emerge -uDN lapack
	emerge -uDN lapack-atlas
	eselect lapack set atlas || exit 0

numpy: portage-dirs python27 atlas
	echo 'x11-base/xorg-server xvfb' > ${EPREFIX}/etc/portage/package.use/numpy
	echo "dev-python/numpy doc lapack test" >> ${EPREFIX}/etc/portage/package.use/numpy
	emerge -uDN --onlydeps numpy
	FEATURES=test emerge -uN --nodeps numpy

scipy: numpy
	emerge -uDN --onlydeps scipy
	# #FEATURES=test emerge -uDN scipy
	emerge -uDN scipy

ipython: pip
	pip install -vUI ipython

#pycuda: pip
pycuda:
	#pip install -vUI pycuda
	echo 'dev-libs/boost python' > ${EPREFIX}/etc/portage/package.use/pycuda
	emerge -uDN pycuda

joblib: pip
	pip install -vUI joblib

scikits.learn: pip
	pip install -vUI scikits.learn

# ============================================================================
# -- MISC
# ============================================================================
graphviz:
	emerge -uDN media-gfx/graphviz

gprof2dot: graphviz
	echo 'dev-util/gprof2dot ~amd64' > ${EPREFIX}/etc/portage/package.keywords/gprof2dot
	emerge -uDN dev-util/gprof2dot

gthumb:
	emerbe -uDN media-gfx/gthumb

sun-jdk:
	echo 'dev-java/sun-jdk Oracle-BCLA-JavaSE' > ${EPREFIX}/etc/portage/package.license/sun-jdk
	emerge -uDN dev-java/sun-jdk

boost:

	
