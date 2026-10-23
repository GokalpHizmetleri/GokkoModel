#!/usr/bin/env python3
"""HF checkpoint'indeki Qwen2.5 chat template'in varsayilan sistem mesajini
GokkoModel kimligiyle degistirir. / Replaces the default system message in the
Qwen2.5 chat template of an HF checkpoint with the GokkoModel identity."""
import json, sys

IDENTITY = ('You are GokkoModel, made by Gökalp Hizmetleri. '
            'Sen kimsin -> Ben GokkoModel. '
            'Seni kim yaptı -> Beni Gökalp Hizmetleri yaptı. '
            'Always reply in Turkish.')
QWEN_DEFAULT = 'You are Qwen, created by Alibaba Cloud. You are a helpful assistant.'

ckpt = sys.argv[1]
path = f'{ckpt}/tokenizer_config.json'
cfg = json.load(open(path, encoding='utf-8'))
tpl = cfg.get('chat_template', '')
assert QWEN_DEFAULT in tpl, 'Qwen varsayilan sistem mesaji bulunamadi / default not found'
cfg['chat_template'] = tpl.replace(QWEN_DEFAULT, IDENTITY)
json.dump(cfg, open(path, 'w', encoding='utf-8'), ensure_ascii=False, indent=2)
n = tpl.count(QWEN_DEFAULT)
print(f'OK: {n} yerde varsayilan mesaj degistirildi / replaced {n} occurrence(s)')
