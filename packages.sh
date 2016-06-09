# copied from https://github.com/richo/babashka so that running
# babashka's bootstrap installs this helper func into the global
# deps.

function install_package() {
  _package_name=$1; shift
  _platform=`uname -s`
  # -a == apt
  # -b == brew
  while getopts "a:b:" opt; do
    case "$opt" in
      a)
        apt_pkg=$OPTARG;;
      b)
        brew_pkg=$OPTARG;;
    esac
  done
  unset OPTIND

  case "`uname -s`" in
    Linux)
     # TODO things other than debian derivatives
     function is_met() {
       dpkg -l | grep ${apt_pkg:-$_package_name}
     }
     function meet() {
       [ -n "$__babushka_force" ] && apt_flags="${apt_flags} -f --force-yes"
       $__babashka_sudo apt-get install $apt_flags ${apt_pkg:-$_package_name}
     }
     ;;
   Darwin)
     # TODO things other than brew
     function is_met() {
       brew list | grep ${brew_pkg:-$_package_name}
     }
     function meet() {
       brew install ${brew_pkg:-$_package_name}
     }
     ;;
  esac
}
