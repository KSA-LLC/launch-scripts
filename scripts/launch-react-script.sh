# TASK: launch a react app with firebase authentication
# . launch-react-script.sh USERNAME TOKEN APPOWNER APPNAME

if [ -z "$1" ]
then
echo "Missing parameter USERNAME (i.e) . launch-react-script.sh USERNAME TOKEN APPOWNER APPNAME"
exit
fi

if [ -z "$2" ]
then
echo "Missing parameter TOKEN (i.e) . launch-react-script.sh USERNAME TOKEN APPOWNER APPNAME"
exit
fi

if [ -z "$3" ]
then
echo "Missing parameter APPOWNER (i.e) . launch-react-script.sh USERNAME TOKEN APPOWNER APPNAME"
exit
fi

if [ -z "$4" ]
then
echo "Missing parameter APPNAME (i.e) . launch-react-script.sh USERNAME TOKEN APPOWNER APPNAME"
exit
fi

# INSTALL GIT
yum update -y
yum remove git -y
yum install wget -y
yum group install "Development Tools" -y
yum install gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel -y
yum install curl-devel expat-devel gettext-devel openssl-devel -y

wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.24.3.tar.gz
tar -xvf git-*.tar.gz
cd git-*
make configure
./configure --prefix=/usr --with-curl --with-expat
make install

# PARTIAL CHECKOUT (REACT ONLY)
git clone \
  --depth 1 \
  --filter=blob:none \
  --no-checkout \
  https://$1:$2@github.com/KSA-LLC/build-scripts.git \
;
cd build-scripts
git checkout main -- react

cd ..
# PREPARE SERVER FOR REACT ENVIRONMENT
. react/bootscript.sh

# LAUNCH REACT WEB APP
git clone https://$1:$2@github.com/KSA-LLC/react-app
. react-app/bootscript.sh $3 $4
