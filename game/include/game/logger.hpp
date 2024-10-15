#include <fmt/format.h>
#include <iostream>

class ILoggerStream {
public:
  virtual void log(std::string message) = 0;
};

class ConsoleStream : public ILoggerStream {
public:
  void log(std::string text) override {
    std::cout << text << "\n";
  }
};

class Logger {
private:
  static ILoggerStream* stream;

public:
  static Logger native;

  template <typename... T>
  void text(std::string message, T&&... args) {
    stream->log(fmt::vformat(message, fmt::make_format_args(args...)));
  }

  template <typename... T>
  void error(std::string message, T&&... args) {
    text(fmt::format("[ERROR] {}", message), args...);
  }

  template <typename... T>
  void info(std::string message, T&&... args) {
    text(fmt::format("[INFO] {}", message), args...);
  }
};