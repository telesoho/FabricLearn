### Port 説明

組織 SDL

|               项                | 运行端口 |                       说明                        |
| :-----------------------------: | :------: | :-----------------------------------------------: |
|      `tlsca.localcoin.jp`       |   6054   |                  TLS CA サーバー                  |
|      `ca.sdl.localcoin.jp`      |   7050   |     sdl 組織の CA サービス、TLS-CA として担当     |
|    `ca.orderer.localcoin.jp`    |   7150   | orderer 组织的 CA 服务， 为联盟链网络提供排序服务 |
| `orderer0.orderer.localcoin.jp` |   7151   |         orderer 组织的 orderer1 成员节点          |
|    `peer0.sdl.localcoin.jp`     |   7250   | soft 组织的 CA 服务， 包含成员： peer1 、 admin1  |
|    `peer1.sdl.localcoin.jp`     |   7251   |            soft 组织的 peer1 成员节点             |
