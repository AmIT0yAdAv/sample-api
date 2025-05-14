const request = require('supertest');
const app = require('../src/server');

describe('API Endpoints', () => {
  test('GET /health should return 200 status', async () => {
    const response = await request(app).get('/health');
    expect(response.statusCode).toBe(200);
    expect(response.body).toHaveProperty('status', 'OK');
    expect(response.body).toHaveProperty('timestamp');
  });

  test('GET /api should return a message', async () => {
    const response = await request(app).get('/api');
    expect(response.statusCode).toBe(200);
    expect(response.body).toHaveProperty('message', 'Hello from the API!');
  });
});
