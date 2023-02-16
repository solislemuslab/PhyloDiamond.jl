include("../src/mapping.jl")
@testset "mapping.jl" begin
    @testset "get_a" begin
        cf=CSV.read("./test/file/N2222_expCF.txt", DataFrame)
        # Reading network
        N = [("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")] ## true network
        i=1
        temp = Array(cf[i, :])
        q = temp[1:4]
        cfs = [temp[5], temp[6], temp[7]]
        n = get_n(N, q)
        @test n == [2,0,2,0]
        cfs_ord = cfs_in_order(N, q, cfs)
        @test round.(cfs_ord;digits=2) == [0.96,0.02,0.02]

        i=69
        temp = Array(cf[i, :])
        q = temp[1:4]
        cfs = [temp[5], temp[6], temp[7]]
        n = get_n(N, q)
        @test n == [0,1,1,2]
        cfs_ord = cfs_in_order(N, q, cfs)
        @test round.(cfs_ord;digits=2) == [0.91,0.05,0.05]


        N = [("A","E"),("C","B"),("D","F"),("G","H")]
        i=1
        temp = Array(cf[i, :])
        q = temp[1:4]
        cfs = [temp[5], temp[6], temp[7]]
        n = get_n(N, q)
        @test n == [2,1,1,0]
        cfs_ord = cfs_in_order(N, q, cfs)
        @test round.(cfs_ord;digits=2) == [0.02,0.96,0.02]


        i=2
        temp = Array(cf[i, :])
        q = temp[1:4]
        cfs = [temp[5], temp[6], temp[7]]
        n = get_n(N, q)
        @test n == [2,2,0,0]
        cfs_ord = cfs_in_order(N, q, cfs)
        @test round.(cfs_ord;digits=2) == [0.06,0.87,0.06]
    end

    @testset "get_n" begin
        @test get_n([("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")], ["C", "E", "G", "H"]) == [0, 1, 1, 2]
        @test get_n([("A", "B"), ("C", "D"), ("E", NaN), ("G", "H")], ["C", "E", "G", "H"]) == [0, 1, 1, 2]
    end

    @testset "cfs_in_order" begin    
        #N2222 (1, 1, 1, 1)
        @test cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", "H")], ["A","H","E","C"], [0.7, 0.2, 0.1])==[0.1, 0.2, 0.7]
        @test cfs_in_order([("E", "F"), ("A", "B"), ("G", "H"), ("C", "D")], ["A","H","E","C"], [0.7, 0.2, 0.1])==[0.2, 0.1, 0.7]
        @test cfs_in_order([("A", "B"), ("E", "F"), ("G", "H"), ("C", "D")], ["E","C","A","H"], [0.7, 0.2, 0.1])==[0.2, 0.7, 0.1]
        #N2122
        @test cfs_in_order([("A", "B"), ("C", NaN), ("E", "F"), ("G", "H")], ["A","B","E","C"], [0.8, 0.1, 0.1])==[0.8, 0.1, 0.1] #2110
        @test cfs_in_order([("A", "B"), ("C", NaN), ("E", "F"), ("G", "H")], ["A","E","C","B"], [0.1, 0.1, 0.8])==[0.8, 0.1, 0.1] #2110
        @test cfs_in_order([("A", "B"), ("C", NaN), ("E", "F"), ("G", "H")], ["E","G","A","C"], [0.7, 0.2, 0.1])==[0.7, 0.2, 0.1] #1111
        @test cfs_in_order([("A", "B"), ("C", NaN), ("E", "F"), ("G", "H")], ["H","G","A","B"], [0.8, 0.1, 0.1])==[0.8, 0.1, 0.1] #2002

        #N2221
        @test cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", NaN)],["E","B","F","C"], [0.1, 0.8, 0.1])==[0.8, 0.1, 0.1] #1120
        @test cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", NaN)],["A","B","C","F"], [0.8, 0.1, 0.1])==[0.8, 0.1, 0.1] #2110
        @test cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", NaN)],["F","G","A","C"], [0.7, 0.2, 0.1])==[0.7, 0.2, 0.1] #1111
        @test cfs_in_order([("A", "B"), ("C", "D"), ("E", "F"), ("G", NaN)],["B","F","A","E"], [0.1, 0.8, 0.1])==[0.8, 0.1, 0.1] #2020

        #N2111
        @test cfs_in_order([("A", "B"), ("C", NaN), ("E", NaN), ("G", NaN)],["E","B","G","A"], [0.1, 0.8, 0.1])==[0.8, 0.1, 0.1] #2011
        @test cfs_in_order([("A", "B"), ("C", NaN), ("E", NaN), ("G", NaN)],["B","E","G","A"], [0.1, 0.1, 0.8])==[0.8, 0.1, 0.1] #2011

        #N2211
        @test cfs_in_order([("A", "B"), ("C", "D"), ("E", NaN), ("G", NaN)],["C","B","D","A"], [0.1, 0.8, 0.1])==[0.8, 0.1, 0.1] #2200
        @test cfs_in_order([("A", "B"), ("C", "D"), ("E", NaN), ("G", NaN)],["A","B","C","D"], [0.8, 0.1, 0.1])==[0.8, 0.1, 0.1] #2200
        @test cfs_in_order([("A", "B"), ("C", "D"), ("E", NaN), ("G", NaN)],["C","G","D","A"], [0.1, 0.8, 0.1])==[0.8, 0.1, 0.1] #1201
        @test cfs_in_order([("A", "B"), ("C", "D"), ("E", NaN), ("G", NaN)],["E","G","C","B"], [0.7, 0.1, 0.2])==[0.7, 0.2, 0.1] #1111
        
    end
end
