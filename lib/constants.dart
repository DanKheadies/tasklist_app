// const baseUrl = 'http://localhost:8080';
const baseUrl = 'http://192.168.1.127:8080';
// const baseUrl = 'http://127.0.0.1:8080';
// const wsUrl = 'ws://localhost:8080/ws'; // throws a Connection refused
// const wsUrl = 'ws://192.168.1.127:8080/ws/'; // throws a 404
// const wsUrl = 'ws://127.0.0.1:8181/ws'; // also 404 (?) but uses 192.168..
// const wsUrl = 'ws://192.168.1.127:8080/ws'; // def seems right, still 404 tho
// const wsUrl = 'ws://echo.websocket.org'; // works
// const wsUrl = 'wss://192.168.1.127:8080/ws'; // handshake termination
// const wsUrl = 'ws://localhost:8080/ws'; // handshake termination
const wsUrl = 'ws://192.168.1.127:8080/ws'; // throws a 404
// Note: not sure if something changed w/ dart frog's websocket or it's a
// general MacOS security thing, but I cannot get the connection established.

const allLists = '/';
const newList = '/lists';
const singleList = '$newList/';
const items = '/items';
const itemsByList = '$items/';
const singleItem = '$items/';

// TODO: try w/ Firebase & Supabase
const db = '/db';
const firebase = '$db/firebase';
const mongodb = '$db/mongodb';
const postgresql = '$db/postgresql';
const cache = '/cache';
const redis = '$cache/redis';

const auth = '/authentication';
const basicAuth = '$auth/basic';
const bearerAuth = '$auth/bearer';

const api = '/api';
const restapi = '$api/restapi';

const files = '/files';
