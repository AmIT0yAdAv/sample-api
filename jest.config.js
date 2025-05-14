module.exports = {
  testEnvironment: 'node',
  coveragePathIgnorePatterns: ['/node_modules/'],
  coverageReporters: ['text', 'lcov', 'clover', 'html'],
  testMatch: ['**/test/**/*.test.js'],
};
