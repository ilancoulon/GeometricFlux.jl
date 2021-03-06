# Changelog

All notable changes to this project will be documented in this file.

## [0.5.2]

- Add scaled Laplacian
- Support CuArrays v2.0 and Flux v0.10.4
- ChebConv, GraphConv, GATConv, GatedGraphConv and EdgeConv support FeaturedGraph
- Add SimpleWeightedGraphs and MetaGraphs as deps
- Fix broadcastly casting error

## [0.5.1]

- GCNConv layer supports FeaturedGraph (#34)
- Support linear algebra for FeaturedGraph
- Add `nv` API for FeaturedGraph
- Add LightGraphs as dependency
- Correct normalized laplacian type
- Fix bug in normalized_laplacian
- Fix Base.show on GCNConv
- Add docs (#35)

## [0.5.0]

- Support scatter operations for MArray (#32)
- Support GCNConv layer accepting graph input (#31)

## [0.4.0]

- Compatible with Julia v1.4 while not support before v1.3
- Not support old version CuArrays, CUDAnative and CUDAapi
- Improve performance of scatter operations for CPU and new benchmark (#29)
- Scatters support almost all Real numbers except Bool on CPU
- Add benchmark for scatter operations
- Implement TopKPool layer (#22)

## [0.3.0]

- Improve performance of scatter operations in both CPU/CUDA version
- Add benchmark result
- Add multihead GAT on graph support
- Move `pool_dim_check` to `Dims` constructor

## [0.2.0]

 - Available on Julia v1.2 and v1.3
 - Convolution layers works with CUDA
 - Provide scatter add, sub, mul, div, max, min, mean for CPU and CUDA
 - Provide pool add, sub, mul, div, max, min, mean for CPU and CUDA
 - Provide gradient of scatter add, sub, mul, div, max, min, mean for CPU and CUDA
 - Provide gradient of pool add, sub, mul, div, max, min, mean for CPU and CUDA
 - Provide gather
 - Provide good abstract for graph network block
 - Integrate message passing scheme and graph network block
 - Add logo
 - Add docs
 - Add layer docs and Base.show
 - Provide dynamically change graph in runtime
 - Provide GlobalPool layer
