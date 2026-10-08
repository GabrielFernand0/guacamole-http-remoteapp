# Segurança

Este projeto está em preparação. Valide-o em laboratório antes de usá-lo com sistemas sensíveis.

- Não versione o arquivo `.env`; use uma senha forte e exclusiva para `RDP_MASTER_PASSWORD`.
- Restrinja RDP à rede do Guacamole ou à interface local. Não exponha a porta 3389 diretamente à Internet.
- Firefox abre somente destinos HTTP/HTTPS fornecidos à sessão. Evite passar dados confidenciais na URL.
- O navegador mantém as proteções padrão e não aceita automaticamente certificados HTTPS inválidos. Instale apenas autoridades certificadoras confiáveis no sistema quando necessário.
- Cada sessão usa perfil temporário, mas isso não substitui isolamento de rede, controle de acesso ou atualizações do host.
- Restrinja o acesso de rede do container aos destinos necessários.
