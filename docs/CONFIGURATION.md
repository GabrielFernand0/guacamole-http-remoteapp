# Configuração

## Build local

1. Copie `.env.example` para `.env`.
2. Defina uma senha longa e exclusiva em `RDP_MASTER_PASSWORD`.
3. Execute `docker compose up --build -d`.

A porta RDP fica vinculada a `127.0.0.1` por padrão. Use `docker compose logs -f remoteapp` para acompanhar e `docker compose down` para encerrar.

## Conexão pelo Apache Guacamole

O serviço `guacd` precisa alcançar o serviço `remoteapp` pela mesma rede Docker. Configure uma conexão RDP para o host `remoteapp`, porta `3389`, com a senha configurada em `RDP_MASTER_PASSWORD`. O URL inicial será passado à sessão pelo mecanismo de programa inicial compatível com a configuração do Guacamole/xRDP. Esse fluxo ainda precisa ser validado com uma instância de teste.

Se Guacamole estiver em outro projeto Compose, conecte os projetos a uma rede Docker dedicada. Quando os serviços compartilham uma rede, eles podem se comunicar sem publicar a porta RDP no host.

## Variáveis

| Nome | Obrigatória | Uso |
| --- | --- | --- |
| `RDP_MASTER_PASSWORD` | Sim | Senha usada pelo xRDP |
| `RDP_BIND_ADDRESS` | Não | Interface local publicada; padrão `127.0.0.1` |
| `RDP_PORT` | Não | Porta publicada no host; padrão `3389` |
| `DEFAULT_URL` | Não | URL de fallback; padrão `about:blank` |
