# practicalcommonlisp
exercise of Practical Common Lisp
http://www.jonathanfischer.net/modern-common-lisp-on-linux/

= Howto install sbcl and slime on emacs in ubuntu =

references:

Download and install SBCL (http://www.sbcl.org/)

Download and install Emacs (http://www.gnu.org/software/emacs/)

Download and install Quicklisp (http://www.quicklisp.org/)


install sbcl:
{{{
gohkim@ws00837:~$ sudo apt-get install sbcl
[sudo] password for gohkim: 
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages were automatically installed and are no longer required:
  linux-headers-4.2.0-18 linux-headers-4.2.0-18-generic
  linux-image-4.2.0-18-generic linux-image-extra-4.2.0-18-generic
Use 'apt-get autoremove' to remove them.
Suggested packages:
  sbcl-doc sbcl-source slime
The following NEW packages will be installed
  sbcl
0 to upgrade, 1 to newly install, 0 to remove and 10 not to upgrade.
Need to get 9.013 kB of archives.
After this operation, 69,8 MB of additional disk space will be used.
Get:1 http://de.archive.ubuntu.com/ubuntu/ wily/universe sbcl amd64 2:1.2.14-1ubuntu1 [9.013 kB]
Fetched 9.013 kB in 4s (1.837 kB/s)
Selecting previously unselected package sbcl.
(Reading database ... 285905 files and directories currently installed.)
Preparing to unpack .../sbcl_2%3a1.2.14-1ubuntu1_amd64.deb ...
Unpacking sbcl (2:1.2.14-1ubuntu1) ...
Processing triggers for man-db (2.7.4-1) ...
Setting up sbcl (2:1.2.14-1ubuntu1) ...
}}}

install emacs:
{{{
$ apt-get update
$ apt-get install emacs
}}}

make ~/lisp and install quicklisp:
{{{
gohkim@ws00837:~$ cd lisp
gohkim@ws00837:~/lisp$ ls
gohkim@ws00837:~/lisp$ curl -O https://beta.quicklisp.org/quicklisp.lisp
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 57144  100 57144    0     0  53840      0  0:00:01  0:00:01 --:--:-- 53858
gohkim@ws00837:~/lisp$ ls
quicklisp.lisp
gohkim@ws00837:~/lisp$ sbcl
This is SBCL 1.2.14.debian, an implementation of ANSI Common Lisp.
More information about SBCL is available at <http://www.sbcl.org/>.

SBCL is free software, provided as is, with absolutely no warranty.
It is mostly in the public domain; some portions are provided under
BSD-style licenses.  See the CREDITS and COPYING files in the
distribution for more information.
* (load "~/lisp/quicklisp.lisp")

  ==== quicklisp quickstart 2015-01-28 loaded ====

    To continue with installation, evaluate: (quicklisp-quickstart:install)

    For installation options, evaluate: (quicklisp-quickstart:help)

T
* (quicklisp-quickstart:install :path "~/lisp")
WARNING: Making lisp part of the install pathname directory

; Fetching #<URL "http://beta.quicklisp.org/client/quicklisp.sexp">
; 0.82KB
==================================================
838 bytes in 0.01 seconds (116.91KB/sec)
; Fetching #<URL "http://beta.quicklisp.org/client/2015-09-24/quicklisp.tar">
; 240.00KB
==================================================
245,760 bytes in 0.73 seconds (329.22KB/sec)
; Fetching #<URL "http://beta.quicklisp.org/client/2015-09-24/setup.lisp">
; 4.94KB
==================================================
5,054 bytes in 0.00 seconds (0.00KB/sec)
; Fetching #<URL "http://beta.quicklisp.org/asdf/2.26/asdf.lisp">
; 194.07KB
==================================================
198,729 bytes in 0.56 seconds (347.80KB/sec)
; Fetching #<URL "http://beta.quicklisp.org/dist/quicklisp.txt">
; 0.40KB
==================================================
408 bytes in 0.00 seconds (0.00KB/sec)
Installing dist "quicklisp" version "2015-12-18".
; Fetching #<URL "http://beta.quicklisp.org/dist/quicklisp/2015-12-18/releases.txt">
; 319.70KB
==================================================
327,371 bytes in 0.52 seconds (611.28KB/sec)
; Fetching #<URL "http://beta.quicklisp.org/dist/quicklisp/2015-12-18/systems.txt">
; 247.56KB
==================================================
253,499 bytes in 0.44 seconds (566.49KB/sec)

  ==== quicklisp installed ====

    To load a system, use: (ql:quickload "system-name")

    To find systems, use: (ql:system-apropos "term")

    To load Quicklisp every time you start Lisp, use: (ql:add-to-init-file)

    For more information, see http://www.quicklisp.org/beta/

NIL
* (ql:add-to-init-file)
I will append the following lines to #P"/home/gohkim/.sbclrc":

  ;;; The following lines added by ql:add-to-init-file:
  #-quicklisp
  (let ((quicklisp-init (merge-pathnames "lisp/setup.lisp"
                                         (user-homedir-pathname))))
    (when (probe-file quicklisp-init)
      (load quicklisp-init)))

Press Enter to continue.


#P"/home/gohkim/.sbclrc"
* gohkim@ws00837:~/lisp$ ls
asdf.lisp         dists           quicklisp       setup.lisp
client-info.sexp  local-projects  quicklisp.lisp  tmp
}}}


run sbcl and install quicklisp-slime-helper:
{{{
gohkim@ws00837:~$ sbcl
This is SBCL 1.2.14.debian, an implementation of ANSI Common Lisp.
More information about SBCL is available at <http://www.sbcl.org/>.

SBCL is free software, provided as is, with absolutely no warranty.
It is mostly in the public domain; some portions are provided under
BSD-style licenses.  See the CREDITS and COPYING files in the
distribution for more information.
* (ql:quickload "quicklisp-slime-helper")
To load "quicklisp-slime-helper":
  Install 3 Quicklisp releases:
    alexandria quicklisp-slime-helper slime
; Fetching #<URL "http://beta.quicklisp.org/archive/slime/2015-07-09/slime-2.14.tgz">
; 1044.71KB
==================================================
1,069,784 bytes in 1.81 seconds (578.15KB/sec)
; Fetching #<URL "http://beta.quicklisp.org/archive/alexandria/2015-05-05/alexandria-20150505-git.tgz">
; 48.78KB
==================================================
49,955 bytes in 0.06 seconds (762.25KB/sec)
; Fetching #<URL "http://beta.quicklisp.org/archive/quicklisp-slime-helper/2015-07-09/quicklisp-slime-helper-20150709-git.tgz">
; 2.16KB
==================================================
2,211 bytes in 0.00 seconds (0.00KB/sec)
; Loading "quicklisp-slime-helper"
[package swank-loader]............................
[package swank/backend]...........................
[package swank-mop]...............................
[package swank/source-path-parser]................
[package swank/source-file-cache].................
[package swank/sbcl]..............................
[package swank/gray]..............................
[package swank/match].............................
[package swank/rpc]...............................
[package swank]...................................
.......
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-util.lisp" (written 30 DEC 2015 03:06:14 PM):
.

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-util.fasl written
; compilation finished in 0:00:00.046
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-repl.lisp" (written 30 DEC 2015 03:06:14 PM):
..........................................
[package swank-repl]...

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-repl.fasl written
; compilation finished in 0:00:00.049
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-c-p-c.lisp" (written 30 DEC 2015 03:06:14 PM):
..

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-c-p-c.fasl written
; compilation finished in 0:00:00.030
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-arglists.lisp" (written 30 DEC 2015 03:06:14 PM):
..................

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-arglists.fasl written
; compilation finished in 0:00:00.366
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-fuzzy.lisp" (written 30 DEC 2015 03:06:14 PM):
....

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-fuzzy.fasl written
; compilation finished in 0:00:00.078
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-fancy-inspector.lisp" (written 30 DEC 2015 03:06:14 PM):
...
.......

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-fancy-inspector.fasl written
; compilation finished in 0:00:00.241
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-presentations.lisp" (written 30 DEC 2015 03:06:14 PM):
.

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-presentations.fasl written
; compilation finished in 0:00:00.028
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-presentation-streams.lisp" (written 30 DEC 2015 03:06:14 PM):
..

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-presentation-streams.fasl written
; compilation finished in 0:00:00.027
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-asdf.lisp" (written 30 DEC 2015 03:06:14 PM):
.....

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-asdf.fasl written
; compilation finished in 0:00:00.090
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-package-fu.lisp" (written 30 DEC 2015 03:06:14 PM):

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-package-fu.fasl written
; compilation finished in 0:00:00.006
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-hyperdoc.lisp" (written 30 DEC 2015 03:06:14 PM):

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-hyperdoc.fasl written
; compilation finished in 0:00:00.001
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-sbcl-exts.lisp" (written 30 DEC 2015 03:06:14 PM):
.

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-sbcl-exts.fasl written
; compilation finished in 0:00:00.012
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-mrepl.lisp" (written 30 DEC 2015 03:06:14 PM):
..................................
[package swank-api]...............................
[package swank-mrepl].

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-mrepl.fasl written
; compilation finished in 0:00:00.028
; compiling file "/home/gohkim/lisp/dists/quicklisp/software/slime-2.14/contrib/swank-trace-dialog.lisp" (written 30 DEC 2015 03:06:14 PM):
............................
[package swank-trace-dialog]..

; /home/gohkim/.slime/fasl/2015-06-01/sbcl-1.2.14.debian-linux-x86-64/contrib/swank-trace-dialog.fasl written
; compilation finished in 0:00:00.029
....................
[package alexandria.0.dev]........................
[package quicklisp-slime-helper]
slime-helper.el installed in "/home/gohkim/lisp/slime-helper.el"

To use, add this to your ~/.emacs:

  (load (expand-file-name "~/lisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "sbcl")


("quicklisp-slime-helper")

}}}

add sbcl and slime-helper.sl into .emacs:
{{{
(setq inferior-lisp-program "sbcl")
(load (expand-file-name "~/quicklisp/slime-helper.el"))
}}}

run emacs and alt-x slime, then you can see CL-USER> prompt.
