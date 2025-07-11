The first UVM component that we will

learn how to build is called an agent.

The role of the agent is to drive and to

monitor one interface of our DUT.

We will start with the agent responsible

for the register access interface. As I

told you in the previous tutorial, this

register access interface is implementing

a standard protocol called APB.

Inside this agent, the first thing that

we need to build is an interface in

order to access the signals part of the

register access interface. This is a

standard Verilog interface in which we

will add all the signals. After that, we

need to build the logic which drives

these signals. For this, we will build a

pair of standard UVM components which are

called sequencer and driver.

These two UVM components will work

together in order to easily drive

transactions on this APB

interface. Once we have the mechanism to

drive transactions on this APB interface,

we will need to build another component

which is monitoring this interface. The

role of this monitor is to collect all

the transactions on this register access

interface and pack them in a

SystemVerilog class. Then this monitor

will use a mechanism from the UVM library

to broadcast the collected information

throughout our environment. The next

component in our agent that we will have

to build is called coverage. The role of

this component is to keep track of what

happened on this interface. So this

component will build something similar to

a database in which we will store what

happened on this interface.

This database will help us determine if

we verified all the scenarios on this

register access interface. The last

component part of our agent is a

configuration component which will help

us tweak a little bit the parameters of

this APB agent. It is very important for

you to learn how to build these standard

UVM agents as you will encounter these

UVM agents in all the verification

projects in which you will work. Once we

have our APB agent, then we will develop

in parallel the agents for the RX

and TX interfaces. These two

interfaces are implementing the same

protocol called MD from memory

data. So, because we are working with the

same group of signals with the same

rules, you can imagine that these two

agents will have some common logic. When

we will build these agents, we will first

develop the common code and then we will

use inheritance to develop different

aspects of the RX and TX

agents. Once we finish developing these

three agents, you'll have a solid

hands-on experience in building such

standard UVM agents. So you'll have a

good knowledge of all the common code

shared by all these three agents. So

because of this, we will create an

extension of the UVM library which will

contain all the common code shared by

all these agents. We'll use our

UVM extension library to update all

these three agents, so you'll see how

easy it is to build a new agent from

scratch once you have this library.

After that, we will start building a

component called model. The role of the

model is to use the information collected

by our agents and build the

expected outputs of our Aligner.

Inside this model component, we will use

the UVM library to build a model of the

registers. So, in here, we will

create the models of our four

registers from the Aligner. And for this,

we will use a lot the UVM library

as it comes with full support for

modeling the registers. Also, the UVM

library comes with a standard mechanism

for updating and checking the registers.

This mechanism is packed into a component

called Predictor. At this point, our

model will be able to predict all the

outputs of our Aligner. And in order to

compare the outputs of our DUT

against the expected outputs generated

by our model, we will build a component

called scoreboard. This scoreboard

component will generate errors when it

will detect differences between the

outputs of the DUT and the outputs

coming from our model. The next component

part of our environment is called

coverage. The role of this coverage

component is to keep track of all the

scenarios in which we tested our

DUT, so there is a difference between the

coverage implemented in our environment

and the coverage from each of these

agents.

The coverage components from the agents

will only keep track of what we verified

on a particular interface, while the

coverage from the environment will have

the full picture and it will keep track

of the scenarios in which we verified the

Aligner. The next UVM component that

we will build in our environment is

called a virtual sequencer. The role of

this component is to give us a mechanism

through which we can easily control all

these agents. The last component part of

our environment is a configuration

component which will help us tweak all

the parameters of our environment.

When we are using the UVM library, the

verification environment will be

instantiated inside each of the

tests that we run. We will have a base

test in which we will create an instance

of our environment and then we will use

inheritance to create different tests for

our DUT. All these components will be

in the end SystemVerilog classes.

But our tests and also the instance

of our DUT will stay inside

the testbench. This testbench is nothing

more than a simple Verilog module in

which we will create the instance of our

DUT and we will start the UVM

mechanism. That's it for this tutorial.

We talked about the environment

architecture and the order in which we

will implement all the components part of

our environment.




















In this tutorial we will talk how to build the basic framework required for us in order to build this

entire verification environment.

And this basic framework is made out of this part the Testbench, the test and the environment the Testbench

will have inside the instance of our aligner the duty.

But in order to make this work, it requires some basic stuff.

For example, it requires a clock generator which will produce a signal like this one.

So the clock is a periodic signal.

An initial reset generator, which will create a reset signal like this one in order to reset all the

registers and the logic to start the UVM.

And this implies a simple call to a function called run test.

And when you call this function, there are two important things happening.

The UVM test will be instantiated and it will run the UVM phases.

Let's focus on this first part.

Instantiate the UVM test.

Remember that I told you that in the Testbench we will have the test, but we will not actually write

any line of code which will create an instance of our test class.

This will be done automatically by UVM and let's see how this is done.

You can imagine that we will have to write many tests in order to verify our duty and for example,

in our case, we will build like a register access test, a random test, and an illegal Eric's access

test.

By the way, it's somehow a standard in the industry to use as a prefix for all your files and class

names.

Something like this a short name for the company, in our case CFS.

A short name for the duty that you will have to verify in our case a liner and then the rest of the

name.

So this is why you will see all the files and all the classes using this prefix.

Let's get back to our problem of how UVM starts the test.

We can tell UVM what test to start by calling this run test function with a string argument, and the

value of the string should be the name of the test class.

So, for example, if we want to start this test, this register access test, then the string will

have the value of the name of the class.

But this is one way to start a test using the UVM mechanism.

There is another option in which we call run test with an empty string, but we specify the name of

the test class in an plus argument.

This plus argument is an argument with which we can invoke the simulator.

All the simulators, like from cadence.

Synopsys mentor, support this feature so you can invoke the simulator with plus UVM test name equals

and then the name of the test class.

And in this way, UVM will know that it will have to start this register access test.

In our case, we will use this second option.

And also in a real project, the second option will be used because this is more flexible.

You don't have to modify the systemverilog code of your test testbench.

In order to change the test, you simply invoke the simulator with some different argument.

So if you invoke the simulator like so, UVM will instantiate this particular test.

But one important thing for this entire mechanism to work is that all your tests will have to inherit

from a base class called UVM test, and this base class is defined under the UVM package.

Let's move to the second thing done by the call to the run test, which is running the UVM phases.

UVM has nine phases and these are build.

Connect.

End of elaboration, start of simulation, run, extract, check, report and final.

These phases are nothing more than some functions called in this particular order, and for each of

them there is a function associated.

Out of all of these, run phase is the only one, which is a task because we should consume time during

the simulation.

During run phase and the rest are functions.

All these phases are defined under another class part of the UVM package called UVM component.

This UVM component is a special class because it must be the parent of all our classes, which are part

of our environment architecture.

And by the way, also UVM test inherits from UVM component.

So all our tests will also inherit from UVM component.

And by the way, we refer to any class that we define which inherits from UVM component as a component.

If we go back to our picture of the environment, you can identify all the components as blue square.

So all these are actually components they will inherit from that UVM component.

One special thing about any component is that it can only be created in one phase.

In the build phase, once we move out of the build phase, then the structure of our environment is

fixed.

Those components will exist in this form up to the end of our simulation.

UVM will call those phase functions in the following way.

When it is in the build phase, it will call build phase for all the components.

When this is done, it will move to the connect phase and then it will call connect phase of all the

components and so on.

Out of these nine phases, most of the time you will actually use only three build phase, because in

this one we will actually create the instances of all these components connect phase, because in this

phase, we will create those connections between our components and run phase.

As in this phase we will actually start our simulation.

So these are the parts that we will build in the test bench.

Now let's move to the test.

As we discussed, we will build this register access test which needs to inherit from UVM test.

But we will have other tests in order to verify different features of our duty.

All these tests will have to have an instance of our environment.

But because we don't really want to have the code which instantiate the environment in all of them,

we will put here an intermediate class called base test, and in this one we will create the instance

of our environment.

And all of our tests will inherit from this base test.

That's about it.

Let's recap on what we talked about.

So we discussed about the initial environment structure and how to start UVM tests and phases.

And in the next tutorial we will code together all the stuff that we talked about in this tutorial.



















# Adımlar
1- testbench modülünü yaz
2- Clock generate devresini tasarla
3- reset generate devresini tasarla
4- Modülü örnekle
5- run_test kısmını yaz ve test adını boş bırak +UVM_TESTNAME parametresi ile simülatöre vermek daha mantıklı
Bu kısımda bir compile edip hataları çözmekte fayda var. Henüz test classını tanımlamadığımız için tek bir hata veriyor olması lazım vum ortamının
- Bo components instantiated. You must either instantiate at least one compponent before calling run_test or use  to do so. To run a test using run_test, user + UVM_TESTNAME or supply the test name in the argument.


6-Test package'ını oluştur.
- başına koruma ekle
- uvm macro kütüphanesi include et
- package içerisini uvm_pkg import et
- >**yazdığın test_base** ve ondan türetilen classları içerisine include et
 packageların başına multiple includean korunmak için şu yapıyı ekle
  `ifndef DOSYA_ADI_SV
    `define DOSYA_ADI

`include "uvm_macros"
  package package_adı;
    import uvm_pkg::*;
    > .. include dosyaları gelecek  
  endpackage
  
  `endif


7- bu package testbench içinde include ile içeri aktar
8- testbench modülü içerisindede import ile de import et



9- UVM test pkg içerisine test class'larını include et
  `ifndef DOSYA_ADI_SV
    `define DOSYA_ADI
`include "uvm_macros"
  package package_adı;
    import uvm_pkg::*;
    
    `include "cfs_algn_test_base.sv"
    `include "cfs_algn_test_req_acces.sv"
  endpackage
  
  `endif


  10- test classlarını yaz
  - koruma ekle
  - classı uvm_test'ten extend et
  - ùvm_component_uitls ile kayıt et  classsı
  - new fonksiyonunu tasarlar bütün componentlerde (string name = "", uvm_componen component) şeklinde parametre alır genelde
  -  > **env class** nesnesi oluşturulacak içeride
     > virtual build fonksiyonu içerisinde bu env class oluşturması gerçeklenecek
  - diğer test classlarını base'den extend et
  - > base_test'ten oluşturulan test sınıflarına virtual run_phase yazıkacak


11- tasarımın kendi package'ını oluştur
- koruma ekle
- uvm_macros include et
- package'ı tanımla
- uvm_pkg import et
- > **environment** classını burada inclulde edeceğiz
- tasarımın kendi package'ını test package'ı dosyasına include et
- tasarımın kendi package'ını test package içerisine import et
  
12- env classını oluştur
- koruma ekle
- classı uvm_env extend et
- component_utils ile kaydet
- new constructure'ını tanımla
- test_base içerisinde bir örneğini oluştur
- test_base içerisinde builde fazda örnekle

13- test_base'den türetilen classlarda run_phase'ı virtual olarak tanımla
- raise objection ekle
- drop objection ile bitir
- 
