#my_vi_fzf_bindings() {
#    echo "Activating fzf bindings"
#    bindkey -M vicmd '?' fzf-history-widget
#    bindkey -M vicmd '/' fzf-history-widget
#}
#zvm_after_init_commands+=(my_vi_fzf_bindings)

function zvm_after_lazy_keybindings() {
    echo "Activating fzf bindings"
    #bindkey -M vicmd '?' fzf-history-widget
    #bindkey -M vicmd '/' fzf-history-widget
    zvm_bindkey vicmd '?' fzf-history-widget
    zvm_bindkey vicmd '/' fzf-history-widget

}


