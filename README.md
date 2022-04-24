# runOS
This started out as a personal project to build a very small Linux imitating linux-0.11. You can find documents and redundant comments in code and README files which is to record learning experience. Feel free to contact me if you find anything wrong(email: boyuanniu@gmail.com)

# prerequisite
This project would be developed in Linux, eihter Ubuntu, CentOS or whatever. The arch which runOS base on is x86-64.<br/><br/>
Because the project refers to assembly and C coding, the according compiler is needed. The __nasm__ and __gcc__ are recommanded. nasm is a operating system independent, and more widely used than masm. Also we need an emulator to create a "computer" provided for runOS running on. Here we would use __qemu__. That's fine to install the runOS into a real hardware.<br/><br/>
Some other tools which are helpful when developing the runOS are recommanded:<br/>
__hexdump__: a utility that displays the contents of binary files in hexadecimal, decimal, octal, or ASCII.<br/>
__objdump__: display information from object files. It can be used to disassemble .bin file.
