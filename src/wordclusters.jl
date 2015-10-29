type WordClusters
    vocab::AbstractArray{AbstractString, 1}
    clusters::AbstractArray{Integer, 1}
    vocab_hash::Dict{AbstractString, Integer}
    function WordCluster(vocab, clusters)
        vocab_hash = Dict{AbstractString, Integer}()
        for (i, word) in enumerate(vocab)
            vocab_hash[word] = i
        end
        new(vocab, clusters, vocab_hash)
    end
end

function show(io::IO, wc::WordClusters)
    print(io, "WordClusters $(length(wc.vocab)) words")
end

"""
`vocabulary(wc)` 

Return all the vocabulary of the WordClusters `wc`.
"""
vocabulary(wc::WordClusters) = wc.vocab

"""
`in_vocabulary(wc, word)`

For the WordCluters `wc`, return `true` if `word` is part of the 
vocabulary of `wc` and `false` otherwise.
"""
in_vocabulary(wc::WordClusters, word::AbstractString) = word in wc.vocab

"""
`index(wc, word)`

Return the index of `word` from the WordCluaters `wc`.
"""
index(wc::WordClusters, word) = wc.vocab_hash[word]

"""
`get_cluster(wc, word)`

Return the cluster number for a word in the vocabulary.
"""
get_cluster(wc::WordClusters, word) = (idx = index(wc, word); wc.clusters[idx])

"""
`get_words(wc, cluster)`

For the WordCluster `wc`, return all the words from a given cluster
number `cluster`.
"""
function get_words(wc::WordClusters, cluster::Int) 
    inds = findin(wc.clusters, cluster)
    return wc.vocab[inds]
end
