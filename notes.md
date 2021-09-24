# Notes

## LDPC codes from communication standards

### DOCSIS 3.1 (Data Over Cable Service Interface Specification)

| `n`           | `k`   | `m = n - k` | Code rate `R = k/n` |
|---------------|-------|-------------|---------------------|
| 16200 (Long)  | 14400 | 1800        | 0.889               |
| 5940 (Medium) | 5040  | 900         | 0.8484              |
| 1080 (Short)  | 810   | 270         | 0.75                |

### WiFi `IEEE 802.11n`

| `n`  | `k`  | `m = n - k` | Code rate `R = k/n` |
|------|------|-------------|---------------------|
| 648  | 234  | 234         | 0.5                 |
|      | 432  | 216         | 0.67                |
|      | 486  | 162         | 0.75                |
|      | 540  | 108         | 0.83                |
|------|------|-------------|---------------------|
| 1296 | 648  | 648         | 0.5                 |
|      | 864  | 432         | 0.67                |
|      | 486  | 234         | 0.75                |
|      | 1080 | 216         | 0.83                |
|------|------|-------------|---------------------|
| 1944 | 972  | 972         | 0.5                 |
|      | 1296 | 648         | 0.67                |
|      | 1458 | 486         | 0.75                |
|      | 1710 | 234         | 0.83                |

### WiMax `IEEE 802.16`

| `n`  | `k`  | `m = n - k` | Code rate `R = k/n` |
|------|------|-------------|---------------------|
| 2304 | 1152 | 1152        | 0.5                 |
|      | 1536 | 768         | 0.67                |
|      | 1728 | 576         | 0.75                |
|      | 1920 | 384         | 0.83                |

> [REF] Mahmudul Hasan, "LDPC Codes from Communication Standards," webdemo,
> Institute of Telecommunications, University of Stuttgart, Germany, Sep. 2021.
> [Online] Available: http://webdemo.inue.uni-stuttgart.de
>
> Bibtex entry: `ldpcwebdemo`
