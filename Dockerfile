FROM rust:1-slim as build

# create a new empty shell project
RUN USER=root cargo new --bin rana
WORKDIR /rana

# copy over manifests
COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

# build and cache dependencies
RUN cargo build --release
RUN rm src/*.rs

# copy source tree
COPY ./src ./src

# build for release
RUN rm ./target/release/deps/rana*
RUN cargo build --release

FROM debian:bullseye-slim

COPY --from=build /rana/target/release/rana .

CMD [ "./rana", "--exit-after" ]