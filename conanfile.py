import os

from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout, CMakeDeps
from conan.tools.files import copy


class MyConanFile(ConanFile):
    name = "dreich"
    version = "1.0"
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps", "CMakeToolchain"
    exports_sources = "*"

    default_options = {
        "fmt/*:header_only": True,
    }

    def requirements(self):
        self.requires("raylib/5.0")
        self.requires("spdlog/1.13.0")

    options = {}

    default_options = {}

    def layout(self):
        cmake_layout(self)

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package_info(self):
        self.cpp_info.libs = ["Dreich"]

    def deploy(self):
        copy(self, "*", src=self.package_folder, dst=self.deploy_folder)
