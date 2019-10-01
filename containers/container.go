package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"syscall"
//	"net"
)

func main() {
	switch os.Args[1] {
		case "run":
			run()
		case "child":
			child()
		default:
			panic("wtf?")
	}
}

//type NetworkConfig struct {
//	BridgeName	string
//	BridgeIP	net.IP
//	ContainerIP	net.IP
//	Subnet		*net.IPNet
//	VethNamePrefix	string
//}





func run() {
	fmt.Printf("runnign %v as PID %d\n", os.Args[2:], os.Getpid())
//	netcmd := exec.Command("ip","link","add","name","veth25","type","veth","peer","name","veth255","netns", strconv.Itoa(os.Getpid()))
//	must(netcmd.Run())

	cmd := exec.Command("/proc/self/exe", append([]string{"child"}, os.Args[2:]...)...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Env = append(os.Environ(), "ENV_VAR1=VALUE1", "ENV_VAR2=VALUE2", "MYNAME=DANIEL")
	cmd.SysProcAttr = &syscall.SysProcAttr {
		Cloneflags: syscall.CLONE_NEWUTS | syscall.CLONE_NEWPID | syscall.CLONE_NEWNS | syscall.CLONE_NEWNET,
//		Cloneflags: syscall.CLONE_NEWUTS | syscall.CLONE_NEWPID | syscall.CLONE_NEWNS ,
		Unshareflags: syscall.CLONE_NEWNS,
	}
	must(cmd.Run())
}



func child() {
	fmt.Printf("runnign %v as PID %d\n", os.Args[2:], os.Getpid())

//	netcmd := exec.Command("ip","link","add","name","veth25","type","veth","peer","name","veth255","netns", strconv.Itoa(os.Getpid()))
//	must(netcmd.Run())

	cg()

	must(syscall.Sethostname([]byte("myhomemadecontainer")))
//	must(syscall.Chroot("/home/daniel/DEV-LEARN/go-fun-yourself/containers/ubuntu-rootfs"))
//	must(os.Chdir("/"))
//	must(syscall.Mount("proc","proc","proc", 0, ""))
	must(syscall.Mount("/home/daniel/DEV-LEARN/go-fun-yourself/containers/ubuntu-rootfs", "/home/daniel/DEV-LEARN/go-fun-yourself/containers/ubuntu-rootfs", "", syscall.MS_BIND, ""))
	must(os.MkdirAll("/home/daniel/DEV-LEARN/go-fun-yourself/containers/ubuntu-rootfs/oldrootfs", 0700))
	must(syscall.PivotRoot("/home/daniel/DEV-LEARN/go-fun-yourself/containers/ubuntu-rootfs", "/home/daniel/DEV-LEARN/go-fun-yourself/containers/ubuntu-rootfs/oldrootfs"))
	must(os.Chdir("/"))
	must(syscall.Mount("proc","proc","proc", 0, ""))

//	must(syscall.Mount("sys","sys","sys", 0, ""))
	cmd := exec.Command(os.Args[2], os.Args[3:]...)
        cmd.Stdin = os.Stdin
        cmd.Stdout = os.Stdout
        cmd.Stderr = os.Stderr

	must(cmd.Run())
	must(syscall.Unmount("/proc", 0))

}

func cg() {
	cgroups := "/sys/fs/cgroup/"
	pids := filepath.Join(cgroups, "pids")
	os.Mkdir(filepath.Join(pids, "myhomemadecontaners"), 0755)
	must(ioutil.WriteFile(filepath.Join(pids, "myhomemadecontaners/pids.max"), []byte("20"), 0700))
	must(ioutil.WriteFile(filepath.Join(pids, "myhomemadecontaners/notify_on_release"), []byte("1"), 0700))
	must(ioutil.WriteFile(filepath.Join(pids, "myhomemadecontaners/cgroup.procs"), []byte(strconv.Itoa(os.Getpid())), 0700))
}



func must(err error) {
	if err != nil {
		panic(err)
	}
}



