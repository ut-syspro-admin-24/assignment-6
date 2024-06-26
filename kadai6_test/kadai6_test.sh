#!/bin/bash
# Test code for syspro2024 kadai6
# Written by Shinichi Awamoto and Daichi Morita
# Edited by Momoko Shiraishi

state=0
warn() { echo $1; state=1; }
dir=$(mktemp -d)
trap "rm -rf $dir" 0

testdir=kadai6_test
termdir=${testdir}/pseudoterm
scriptdir=${testdir}/script


kadai-a() {
    if [ -d kadai-a ]; then
        cp -r kadai-a $dir
        pushd $dir/kadai-a > /dev/null 2>&1

        if [ ! -f Makefile ]; then
            warn "kadai-a: Missing Makefile"
        fi

        local bin=count
        make $bin > /dev/null 2>&1

        if [ ! -f $bin ]; then
            warn "kadai-a: Failed to generate the binary($bin) with '$ make $bin'"
        fi

        local errno=0
        check-ish a
        if [[ $errno -eq 10 ]]; then
            warn "kadai-a: count did not exit after 10 ctrl-c"
        elif [[ $errno -ne 0 ]]; then
            warn "kadai-a: count exited after $errno ctrl-c"
        fi

        make clean > /dev/null 2>&1

        if [ -f $bin ]; then
            warn "kadai-a: Failed to remove the binary($bin) with '$ make clean'."
        fi

        if [ ! -z "`find . -name \*.o`" ]; then
            warn "kadai-a: Failed to remove object files(*.o) with '$ make clean'."
        fi

        if [ `grep '\-Wall' Makefile | wc -l` -eq 0 ]; then
            warn "kadai-a: Missing '-Wall' option."
        fi

        popd > /dev/null 2>&1
    else
        warn "kadai-a: No 'kadai-a' directory"
    fi
}

kadai-b() {
    if [ -d kadai-bcde ]; then
        cp -r kadai-bcde $dir
        pushd $dir/kadai-bcde > /dev/null 2>&1

        if [ ! -f Makefile ]; then
            warn "kadai-b: Missing Makefile"
        fi

        local bin=ish
        make $bin > /dev/null 2>&1

        if [ ! -f $bin ]; then
            warn "kadai-b: Failed to generate the binary($bin) with '$ make $bin'"
        fi

        local errno=0
        check-ish b
        case $errno in
        1)
            warn "kadai-b: ish was not the foreground process after /bin/ls";;
        2)
            warn "kadai-b: ish was killed by ctrl-c (SIGINT)";;
        3)
            warn "kadai-b: sleep was not running as a foreground process";;
        4)
            warn "kadai-b: sleep survived ctrl-c (SIGINT)";;
        5)
            warn "kadai-b: ish was killed by ctrl-c (SIGINT) while sleep";;
        esac

        make clean > /dev/null 2>&1

        if [ -f $bin ]; then
            warn "kadai-b: Failed to remove the binary($bin) with '$ make clean'."
        fi

        if [ ! -z "`find . -name \*.o`" ]; then
            warn "kadai-b: Failed to remove object files(*.o) with '$ make clean'."
        fi

        if [ `grep '\-Wall' Makefile | wc -l` -eq 0 ]; then
            warn "kadai-b: Missing '-Wall' option."
        fi

        popd > /dev/null 2>&1
    else
        warn "kadai-b: No 'kadai-bcde' directory"
    fi
}

kadai-c() {
    if [ -d kadai-bcde ]; then
        cp -r kadai-bcde $dir
        pushd $dir/kadai-bcde > /dev/null 2>&1

        if [ ! -f Makefile ]; then
            warn "kadai-c: Missing Makefile"
        fi

        local bin=ish
        make $bin > /dev/null 2>&1

        if [ ! -f $bin ]; then
            warn "kadai-c: Failed to generate the binary($bin) with '$ make $bin'"
        fi

        local errno=0
        check-ish c
        case $errno in
        1)
            warn "kadai-c: /bin/sleep 10 & was not executed as a background process";;
        2)
            warn "kadai-c: ish was not the foreground process after /bin/sleep 10 &";;
        esac

        make clean > /dev/null 2>&1

        if [ -f $bin ]; then
            warn "kadai-c: Failed to remove the binary($bin) with '$ make clean'."
        fi

        if [ ! -z "`find . -name \*.o`" ]; then
            warn "kadai-c: Failed to remove object files(*.o) with '$ make clean'."
        fi

        if [ `grep '\-Wall' Makefile | wc -l` -eq 0 ]; then
            warn "kadai-c: Missing '-Wall' option."
        fi

        popd > /dev/null 2>&1
    else
        warn "kadai-c: No 'kadai-bcde' directory"
    fi
}

kadai-d() {
    if [ -d kadai-bcde ]; then
        cp -r kadai-bcde $dir
        pushd $dir/kadai-bcde > /dev/null 2>&1

        if [ ! -f Makefile ]; then
            warn "kadai-d: Missing Makefile"
        fi

        local bin=ish
        make $bin > /dev/null 2>&1

        if [ ! -f $bin ]; then
            warn "kadai-d: Failed to generate the binary($bin) with '$ make $bin'"
        fi

        local errno=0
        check-ish d
        case $errno in
        1)
            warn "kadai-d: ish was stopped by ctrl-z (SIGSTOP)";;
        2)
            warn "kadai-d: ish was not the foreground process after suspending /bin/sleep 10";;
        3)
            warn "kadai-d: sleep was killed by ctrl-z (SIGSTOP)";;
        4)
            warn "kadai-d: ish was not the foreground process after bg";;
        5)
            warn "kadai-d: sleep was not done after bg";;
        esac

        make clean > /dev/null 2>&1

        if [ -f $bin ]; then
            warn "kadai-d: Failed to remove the binary($bin) with '$ make clean'."
        fi

        if [ ! -z "`find . -name \*.o`" ]; then
            warn "kadai-d: Failed to remove object files(*.o) with '$ make clean'."
        fi

        if [ `grep '\-Wall' Makefile | wc -l` -eq 0 ]; then
            warn "kadai-d: Missing '-Wall' option."
        fi

        popd > /dev/null 2>&1
    else
        warn "kadai-d: No 'kadai-bcde' directory"
    fi
}

kadai-e() {
    if [ -d kadai-bcde ] && [ -f kadai-bcde/report-e.txt ]; then
        cp -r kadai-bcde $dir
        pushd $dir/kadai-bcde > /dev/null 2>&1

        if [ ! -f Makefile ]; then
            warn "kadai-e: Missing Makefile"
        fi

        local bin=ish
        make $bin > /dev/null 2>&1

        if [ ! -f $bin ]; then
            warn "kadai-e: Failed to generate the binary($bin) with '$ make $bin'"
        fi

        local errno=0
        check-ish e
        case $errno in
        1)
            warn "kadai-e: sleep was not executed at the background";;
        2)
            warn "kadai-e: ish was not the foreground process after executing sleep at the background";;
        3)
            warn "kadai-e: sleep was not the foreground process after fg";;
        4)
            warn "kadai-e: ish was not the foreground process in the end";;
        esac

        make clean > /dev/null 2>&1

        if [ -f $bin ]; then
            warn "kadai-e: Failed to remove the binary($bin) with '$ make clean'."
        fi

        if [ ! -z "`find . -name \*.o`" ]; then
            warn "kadai-e: Failed to remove object files(*.o) with '$ make clean'."
        fi

        if [ `grep '\-Wall' Makefile | wc -l` -eq 0 ]; then
            warn "kadai-e: Missing '-Wall' option."
        fi

        popd > /dev/null 2>&1
    fi
}

check-ish() {
    local common=${dir}/${scriptdir}/common.sh
    local robot=${dir}/${scriptdir}/robot-$1.sh

    ${dir}/${termdir}/pseudoterm `pwd`/$bin $robot $common
    local RET=$?

    local zombie=0
    [[ -r ____RESULT.sh ]] && . ____RESULT.sh

    if [[ $RET -ne 0 ]]; then
	    warn "${FUNCNAME[1]}: ish done with exit status=$RET"
    fi

    [[ $zombie -ne 0 ]] && warn "${FUNCNAME[1]}: There is a zombie process"

    rm -f ____*
}

build-term() {
    cp -r $(dirname $(realpath $0)) ${dir}
    pushd ${dir}/${termdir}/ > /dev/null 2>&1
    make pseudoterm > /dev/null 2>&1
    popd > /dev/null 2>&1
}

if [ $# -eq 0 ]; then
    echo "#############################################"
    echo "Running tests..."
fi
build-term
for arg in {a..e}; do
    if [ $# -eq 0 ] || [[ "$@" == *"$arg"* ]]; then kadai-$arg; fi
done
if [ $# -eq 0 ]; then
    if [ $state -eq 0 ]; then echo "All tests have passed!"; fi
    echo "#############################################"
fi
exit $state
