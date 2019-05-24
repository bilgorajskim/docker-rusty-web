FROM rust:latest

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install nodejs yarn
RUN rustup update && rustup install stable && rustup default stable
RUN rustup target add wasm32-unknown-unknown
RUN cargo +stable install wasm-bindgen-cli
RUN apt-get install -y build-essential cmake
RUN git clone https://github.com/WebAssembly/binaryen.git
RUN cd binaryen && cmake . && make
RUN cd binaryen && cp bin/* /usr/bin