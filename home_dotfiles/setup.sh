inputs=(ideavimrc)
outputs=(.ideavimrc)

for i in {0..1}; do
	ln -s ~/.config/home_dotfiles/"${inputs[i]}" ~/"${outputs[i]}"
done
