// const baseUrl = 'http://localhost:8080';
const baseUrl = 'http://192.168.1.127:8080';
// const baseUrl = 'http://127.0.0.1:8080';
const wsUrl = 'ws://192.168.1.127:8080';

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
