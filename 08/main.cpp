#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <numeric>
#include <ranges>

int visible(const std::vector<std::vector<int>>& grid, size_t x, size_t y) {
    int view = 1;
    // -->
    int cnt = 1;
    for (size_t column = y; column < grid.size() - 1; ++ column) {
        if (grid[x][y] <= grid[x][column + 1]) {
            break;
        } 
        cnt += 1;
    }
    view *= cnt;
    cnt = 1;
    // <--
    for (size_t column = y; column > 0;-- column) {
        if (grid[x][y] <= grid[x][column - 1]) {
            break;
        } 
        cnt += 1;
    }
    view *= cnt;
    cnt = 1;
    for (size_t row = x; row < grid.size() - 1; ++ row) {
        if (grid[x][y] <= grid[row + 1][y]) {
            break;
        }
        cnt += 1;
    }
    view *= cnt;
    cnt = 1;
    for (size_t row = x; row > 0; -- row) {
        if (grid[x][y] <= grid[row - 1][y]) {
            break;
        }
        cnt += 1;
    }
    view *= cnt;
    return view;
}

auto main() -> int {
    std::vector<std::string> lines;
    std::string s;
    while (std::getline(std::cin, s)) {
        lines.emplace_back(std::move(s));
    }
    std::vector<std::vector<int>> sizes;
    for (const auto& s: lines) {
        std::vector<int> line;
        for (char c: s) {
            line.emplace_back(c - '0');
        }
        sizes.emplace_back(std::move(line));
    } 
    int count = 0;
    for (size_t i = 0; i < sizes.size(); ++i) {
        for (size_t j = 0; j < sizes[i].size(); ++j) {
            if (i == 0 || j == 0 || i == sizes.size() - 1 || j == sizes[i].size() - 1) {
                sizes[i][j] = 9;
            }
        }
    }
    for (size_t i = 1; i < sizes.size() - 1; ++ i) {
        for (size_t j = 1; j < sizes[i].size() - 1; ++ j) {
            count = std::max(count, visible(sizes, i, j));
        }
    } 

    std::cout << count << std::endl;
}