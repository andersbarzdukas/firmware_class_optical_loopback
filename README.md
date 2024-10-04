# firmware_class_optical_loopback
Tutorials with goal of implementing an optical loopback.

```
git clone git@github.com:andersbarzdukas/firmware_class_optical_loopback.git
cd firmware_class_optical_loopback
git branch <YOUR NAME>_development
git push -u origin <YOUR NAME>_development
git checkout <YOUR NAME>_development
```
if the checkout option above does not work, please try the following below.

```
git clone https://github.com/andersbarzdukas/fsm_firmware_project.git
```

Rought outline for this project:

## Week 1: 
- In class: Add an ILA, VIO, and FIFO. Then look at simulation and generate bitstream
- Out of class: Add one of the following modifications: Blink the LEDs counting up in binary, add the ability to change the LED blinking frequency with the ILA, or add FIFOs that are read with slower or faster clocks and look at the behavior in the ILA

## Week 2: 
- In class: Look at the ILA of the FIFO signals and look at basic 8b/10b communication. Look at example design for 8b/10b communication
- Out of class: Nothing

## Week 3: 
- In class: Add example design for 8b/10b communications at 1.6Gbps into the firmware project and look at simulation
- Out of class: Generate the bitstream (depending on where we get to in class)

## Week 4:
- In class: Connect signals to the ILA to monitor the 8b/10b link
- Out of class: Change speed of 8b/10b communication to 4.8Gbps

## Week 5: 
- In class: Change the data width of the 8b/10b communication
- Out of class: Nothing (right now)
