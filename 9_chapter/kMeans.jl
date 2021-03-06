using Clustering, RDatasets, Random, Measures, Plots; pyplot()
Random.seed!(0)

df = dataset("cluster", "xclara")
data = copy(convert(Array{Float64}, df)')

seeds = initseeds(:rand, data, 3)
xclara_kmeans = kmeans(data, 3)

println("Number of clusters: ", nclusters(xclara_kmeans))
println("Counts of clusters: ", counts(xclara_kmeans))

df.Group  = assignments(xclara_kmeans)

p1 = scatter(df[:, :V1], df[:, :V2], c=:blue, msw=0)
     scatter!(df[seeds, :V1], df[seeds, :V2], markersize=12, c=:red, msw=0)

p2 = scatter( df[df.Group .== 1, :V1], df[df.Group .== 1, :V2], c=:blue, msw=0)
     scatter!( df[df.Group .== 2, :V1], df[df.Group .== 2, :V2], c=:red, msw=0)
     scatter!( df[df.Group .== 3, :V1], df[df.Group .== 3, :V2], c=:green, msw=0)

plot(p1,p2,legend=:none,ratio=:equal,
    size=(800,400), xlabel="V1", ylabel="V2", margin = 5mm)
