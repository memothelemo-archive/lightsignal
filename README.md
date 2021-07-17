# LightSignal

The lightest and fastest Signal class ever made, even faster than Knit's Signal.

Download the `benchmarku.rbxl` file for benchmark purposes. This benchmark test is coded fairly as possible (_by the way, you can see what benchmark module does_).

**Wait method is slower than Bindable because it uses Heartbeat event to detect invokes**

## Benchmarks

| Task                        | Knit Signal | LightSignal | BindableEvent |
| --------------------------- | ----------- | ----------- | ------------- |
| Firing 1000 connections     | 2.60ms      | 11.5μs      | 1.88ms        |
| Wait times test (0.1)       | 931ms       | 141ms       | 112ms         |
| Destroying 1000 connections | 33.6μs      | 5.41μs      | 14.0μs        |

## Warning (Edited: 07/17/2021)

This module does not ensures memory leakage and it doesn't give an error (if something goes wrong with the callback function) because it uses coroutine to spawn functions. I will try my best to how to do that in the next release)
