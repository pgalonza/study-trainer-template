# Study trainer template

```bash
docker build -t practice/<name of practice>:<version> .
docker run -it --rm --name task --cap-add=NET_ADMIN <name of practice>:<version>
```
