#!/bin/bash

# ディレクトリパスを指定
DIR="exp"

# 必ず 000 フォルダが存在することを確認
if [ ! -d "$DIR/000" ]; then
  echo "Error: $DIR/000 does not exist."
  exit 1
fi

# 最後の番号を取得する
latest_num=$(ls "$DIR" | grep -E '^[0-9]{3}$' | sort -n | tail -n 1)

# 最後の番号に1を足す
new_num=$((10#$latest_num + 1))

# 新しいディレクトリ名を三桁のゼロ埋めに変換
new_dir=$(printf "%03d" "$new_num")

# 新しいディレクトリを作成
mkdir "$DIR/$new_dir"

# 直前のディレクトリから新しいディレクトリに内容をコピー
cp -r "$DIR/$latest_num/"* "$DIR/$new_dir/"

echo "New directory created: $DIR/$new_dir"
echo "Copied contents from $DIR/$latest_num to $DIR/$new_dir"
