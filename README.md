# 16-bit-RISC-Processor
Tried implementing an ARM-based RISC CPU we learned to design in school 

Based on Von Neumann architecture, the Processor has a shared Memory for Data and Instruction

RTL Design & Logic probably contains plenty of mistakes. Will try and fix them, and add more details soon!!

Working to increase size to 32-bit & add Branching Instructions, a Branch Predictor, and some I/O Memory-mapped ports

![RISC Processor (1)](https://user-images.githubusercontent.com/34355989/131229780-c1a3811e-97c1-46cd-99f5-753cdd564696.jpg)

Instruction Set Architecture:

![CPU_ISA](https://user-images.githubusercontent.com/34355989/132104486-d62c129c-f9f9-43a4-bff4-340744c110ef.PNG)

Instruction Type: RRR, RR, RRI, JAL

![CPU_INSTRUCTION_FORMAT](https://user-images.githubusercontent.com/34355989/132104489-3404e934-ce09-4fde-9b02-9f45f44d9c6d.PNG)

Instruction Cycle: Fetch -> Decode -> Execute

Pipelined Stages: F0->F1->F2->D0->(E0->E1->E2 OR E3->E4 OR E5->E6->E7)

![CPU_INSTRUCTION_CYCLE](https://user-images.githubusercontent.com/34355989/132104495-23361050-b7db-4e9b-a66e-c880be1f05a1.PNG)

