JS_TEST=$(patsubst src/%.js,build/%.js,$(wildcard src/*.js))


help:
	@echo "Options:"
	@echo "    make help   ───>  Show commands (You are here)"
	@echo "    make app    ───>  Build app"
	@echo "    make demo   ───>  Build app & serve built app"
	@echo "    make dev    ───>  Build app & serve built app & rebuild on file change"
	@echo "    make clean  ───>  Remove all built files"


app: node_modules build build/index.html build/elm.js $(JS_TEST)

dev: clean app
	make -j2 \
		dev-server \
		dev-file-watch \

demo: clean app
	make dev-server

build:
	mkdir build

clean:
	rm -rf build

dev-server:
	@echo "\n\n____________________________________________\n"
	@echo "Serving app on         http://localhost:8080"
	@echo "____________________________________________\n"
	@npx http-server build \
		-c-1 \
		--port 8080 \
		--silent \
		--proxy http://localhost:8080? \

dev-file-watch:
	while true; do \
		inotifywait -q -r src -e close_write .; \
		make app; \
	done

build/index.html: src/index.html
	@echo "$< ───> $@"
	@cp $< $@

build/elm.js: src/Main.elm src/Debug/Extra.elm
	@echo $(ELM_SRC)
	@elm make src/Main.elm --output build/elm.js

build/%.js: src/%.js
	@echo "$< ───> $@"
	@cp $< $@

node_modules: package-lock.json
	@npm i