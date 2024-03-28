
# Load packages and set seed
set.seed(123)
library(here)
library(tidyverse)
library(patchwork)

# Fig. 1: PCA plot + expression triangle (cotton) ----
load(here("products", "plots", "p_pca_combined.rda"))
load(here("products", "plots", "p_triangle_all.rda"))

## Rename AD1 and AD4 to "ADX" and recombine plots
p1 <- p_pca_combined[[1]] +
    theme(
        legend.box = "horizontal", 
        text = element_text(size = 16)
    ) +
    scale_color_manual(
        labels = c("A2", "ADX", "D5", "midparent"),
        values = HybridExpress:::ppal(NULL, "pca")
    ) +
    ggrepel::geom_text_repel(
        aes(label = ifelse(Sample == "D5_CK2", Sample, NA))
    )

p2 <- p_pca_combined[[2]] +
    theme(
        legend.box = "horizontal", 
        text = element_text(size = 16)
    ) +
    scale_color_manual(
        labels = c("A2", "ADX", "D5", "midparent"),
        values = HybridExpress:::ppal(NULL, "pca")
    ) +
    ggrepel::geom_text_repel(
        aes(label = ifelse(Sample == "D5_CK2", Sample, NA))
    )

p_pca <- wrap_plots(p1, p2) +
    plot_layout(guides = "collect") &
    theme(legend.position = "bottom")

fig1 <- wrap_plots(
    p_pca,
    p_triangle_all,
    nrow = 2,
    heights = c(1, 3)
) +
    plot_annotation(tag_levels = "A")

## Save figure
ggsave(
    fig1,
    filename = here("products", "figs", "fig1.pdf"),
    width = 13, height = 16
)

ggsave(
    fig1,
    filename = here("products", "figs", "fig1.png"),
    width = 13, height = 16, dpi = 300
)

# Fig. 2: UpSet plot + partition frequencies (cotton) ----
load(here("products", "plots", "p_upset_all.rda"))
load(here("products", "plots", "p_freq_combined.rda"))

fig2 <- wrap_plots(
    p_upset_all,
    p_freq_combined,
    nrow = 2,
    heights = c(1.4, 2)
) +
    plot_annotation(
        tag_levels = list(c("A", "B", "C", ""))
    )

ggsave(
    fig2, 
    filename = here("products", "figs", "fig2.pdf"),
    width = 11, height = 11
)

ggsave(
    fig2, 
    filename = here("products", "figs", "fig2.png"),
    width = 11, height = 11, dpi = 300
)

# Fig. 3: ----
load(here("products", "plots", "p_pca_b2.rda"))
load(here("products", "plots", "p_triangle_b2.rda"))
load(here("products", "plots", "p_freq_combined_b2.rda"))

p_pca_final <- wrap_plots(
    p_pca_b2[[1]] + theme(text = element_text(size = 16)),
    p_pca_b2[[1]] + theme(text = element_text(size = 16)),
    ncol = 2
) +
    plot_layout(guides = "collect") &
    theme(legend.position = "bottom")

fig3 <- wrap_plots(
    p_pca_final,
    p_triangle_b2,
    p_freq_combined_b2,
    ncol = 1,
    heights = c(1, 2, 2)
) +
    plot_annotation(tag_levels = list(c("A", "B", "C", "D", "E")))

ggsave(
    fig3, 
    filename = here("products", "figs", "fig3.pdf"),
    width = 15, height = 15
)

ggsave(
    fig3, 
    filename = here("products", "figs", "fig3.png"),
    width = 15, height = 15, dpi = 300
)

