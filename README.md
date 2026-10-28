# tentacle_learn

**One capability bit from GBT V8, packaged standalone.** No. 204 of 341,
`recon` domain (Recon).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **触手扫描·采集·学习**（主人令 2026-10-16：这是必要的）：四步闭环 **scan → collect → extract → learn**，末尾**复验**“真的进了语料/可被现读”。面：能力面·页面面·文件面·设备面·网面（只对授权域）。红线：只扫/只采**授权与公开**面 · 隐私脱敏 · 采集物与语料**不外发** · 每步留痕 · 拿不准的不进 learn。op=scan/collect/extract/learn/loop/check/route（**全只读·零作用域·不出网**）；真扫真采走 browser/native_browser/sec_sweeper/触手眼。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-tentacle-learn.git
cd gbt-tentacle-learn
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_tentacle_learn info                  # capability card
python -m gbt_tentacle_learn spec --json           # machine-readable contract
python -m gbt_tentacle_learn check --payload '{}'
python -m gbt_tentacle_learn run   --payload '{}'
```

Real `info` output from this machine:

```text
tentacle_learn  (recon)  v1.0.0
----------------------------------------
**触手扫描·采集·学习**（主人令 2026-10-16：这是必要的）：四步闭环 **scan → collect → extract → learn**，末尾**复验**“真的进了语料/可被现读”。面：能力面·页面面·文件面·设备面·网面（只对授权域）。红线：只扫/只采**授权与公开**面 · 隐私脱敏 · 采集物与语料**不外发** · 每步留痕 · 拿不准的不进 learn。op=scan/collect/extract/learn/loop/check/route（**全只读·零作用域·不出网**）；真扫真采走 browser/native_browser/sec_sweeper/触手眼。

gated      : True   <- needs explicit consent
external   : False
multi-op   : True
params     : (none)
values     : scan, collect, extract, learn, loop, check, route
```

Wire a real implementation:

```python
from gbt_tentacle_learn import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（7 个）**：`scan`、`collect`、`extract`、`learn`、`loop`、`check`、`route`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Gated: this bit is marked `safe: false` in the registry — it can change state that no inverse action restores.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.15s
```

## Provenance

| field | value |
|---|---|
| capability | `tentacle_learn` |
| domain | `recon` |
| handler | `tentacle_learn` |
| safe | `False` (gated = `True`) |
| external | `False` |
| atlas page | [recon/tentacle_learn](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/recon/tentacle_learn.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
