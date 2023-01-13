FROM rust:1-slim

WORKDIR /usr/src/rana
COPY . .

RUN cargo install --path .

CMD ["rana"]