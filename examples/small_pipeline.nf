params.query = "$HOME/sample.fa"
params.db = "$HOME/tools/blast-db/pdb/pdb"


process blast {
    output top_hits

    """
    blastp -db ${params.db} -query ${params.query} -outfmt 6 > blast_result
    cat blast_result | head -n 10 | cut -f 2 > top_hits
    """
}


process extractTopHits {
    input top_hits
    output sequences

    "blastdbcmd -db ${params.db} -entry_batch $top_hits > sequences"
}

process align {
    input sequences
    echo true

    "t_coffee $sequences 2>&- | tee align_result"
}
