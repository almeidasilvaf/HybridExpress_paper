
get_partition_counts <- function(partition_list) {
    
    # Get a count matrix with number of genes per category
    mat <- Reduce(cbind, lapply(partition_list, function(x) {
        return(as.matrix(table(x$Category)))
    }))
    
    # Rename columns
    colnames(mat) <- names(partition_list)
    
    return(mat)
}

plot_partition_counts <- function(
        partition_counts, coldata = NULL, palette = "Blues",
        ...
) {
    
    # Map levels of coldata and rowdata variables to colors
    rowdata <- data.frame(
        row.names = seq(1, 12, 1), 
        Class = factor(
            c(
                "ADD", "ELD_P2", "DOWN", "ELD_P1", "UP", "UP", 
                "DOWN", "UP", "ELD_P1", "DOWN", "ELD_P2", "ADD"
            ),
            levels = c("UP", "DOWN", "ADD", "ELD_P1", "ELD_P2")
        )
    )
    rowcolors <- HybridExpress:::metadata2colors(rowdata)$colors
    colcolors <- NULL
    if(!is.null(coldata)) { colcolors <- HybridExpress:::metadata2colors(coldata)$colors }
    
    ann_colors <- c(rowcolors, colcolors)
    
    hm <- ComplexHeatmap::pheatmap(
        partition_counts, name = "Counts",
        color = colorRampPalette(brewer.pal(9, palette))(100),
        border_color = NA,
        main = "Gene counts per partition",
        annotation_row = rowdata,
        annotation_col = if(is.null(coldata)) NA else coldata,
        annotation_colors = ann_colors,
        ...
    )
    
    return(hm)
}
