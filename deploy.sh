# https://qiita.com/pugiemonn/items/e5fb508df690a323ee14
#!/bin/bash
# 配置したい設定ファイル
# dotfiles=(.zshrc .tmux.conf)

# .zshrc と .tmux.conf という設定ファイルのシンボリックリンクを
# ホームディレクトリ直下に作成する
# for file in "${dotfiles[@]}"; do
#         ln -svf $file ~/
# done

ln -s ~/dotfiles/.zshrc ~/.zshrc
