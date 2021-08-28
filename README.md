# 16-bit-RISC-Processor
Tried implementing an ARM-based RISC CPU we learned to design in school 

Based on Von Neumann architecture, the Processor has a shared Memory for Data and Instruction

RTL Design & Logic probably contains plenty of mistakes. Will try and fix them, and add more details soon!!

Working to increase size to 32-bit & add Branching Instructions, a Branch Predictor, and some I/O Memory-mapped ports

![RISC Processor (3)](https://user-images.githubusercontent.com/34355989/131222475-7010275d-9a94-4684-b708-0395ec91d95d.jpg)

Instruction Set Architecture:

![CPU_ISA](https://user-images.githubusercontent.com/34355989/119415327-6093b380-bcbf-11eb-8a33-f40fd2a8862c.PNG)

Instruction Type: RRR, RR, RRI, JAL

![CPU_INSTRUCTION_FORMAT](https://user-images.githubusercontent.com/34355989/119415344-6a1d1b80-bcbf-11eb-92e1-9679f9b6dcd1.PNG)

Instruction Cycle: Fetch -> Decode -> Execute

Pipelined Stages: F0->F1->F2->D0->(E0->E1->E2 OR E3->E4 OR E5->E6->E7)

![CPU_INSTRUCTION_CYCLE](https://user-images.githubusercontent.com/34355989/119415356-70ab9300-bcbf-11eb-93c1-609aa4a5bb2a.PNG)
