# Kaggleなどのコンペ用のテンプレート

## build

```bash
docker compose up -d --build
```

## usage

* 基本的に`exp`内で作業する

```bash
chmod +x make_exp.sh
```

で権限を付与したあとに

```bash
./make_exp.sh
```

を実行することで`exp`の中に一番新しい番号のフォルダの中身をコピーしたフォルダが作成される
