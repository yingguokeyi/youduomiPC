package common;

import redis.clients.jedis.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class RedisClient {


	private static HashMap<String,ShardedJedis> shardedJedis = new HashMap<String,ShardedJedis>();
	private static HashMap<String, JedisPool> shardedJedisPool = new HashMap<String, JedisPool>();
	private static HashMap<String, Integer> shardedWhich = new HashMap<String, Integer>();
	
	private RedisClient() {
	}


	/**
	 * 初始化切片池
	 */
	/*public static void initialShardedPool(String ip,Integer port,String dbName) {
		// 池基本配置
		JedisPoolConfig config = new JedisPoolConfig();
		config.setMaxTotal(20);
		config.setMaxIdle(5);
		config.setMaxWaitMillis(1000l);
		config.setTestOnBorrow(false);
		// slave链接
		List<JedisShardInfo> shards = new ArrayList<JedisShardInfo>();
		shards.add(new JedisShardInfo(ip, port, dbName));

		// 构造池
		@SuppressWarnings("resource")
		ShardedJedisPool shardedJedisPool = new ShardedJedisPool(config, shards);
		ShardedJedis sj = shardedJedisPool.getResource();
		shardedJedis.put(dbName,sj);
	}*/
	public static void initialPool(String ip, Integer port, String dbName, int which) {
		// 池基本配置
		JedisPoolConfig config = new JedisPoolConfig();
		config.setMaxTotal(20);
		config.setMaxIdle(5);
		config.setMaxWaitMillis(1000l);
		config.setTestOnBorrow(false);

		JedisPool jedisPool = new JedisPool(config, ip, port);
		Jedis sj = jedisPool.getResource();
		sj.select(which);
		shardedJedisPool.put(dbName, jedisPool);
		shardedWhich.put(dbName, which);
	}

	public static void hset(String dbName,String key,String field,String value) {
		shardedJedis.get(dbName).hset(key, field, value);
	}

	public static void hset(String dbName, String key, String field, String value, Integer seconds) {
		try (Jedis jedis = shardedJedisPool.get(dbName).getResource()) {
			jedis.select(shardedWhich.get(dbName));
			jedis.hset(key, field, value);
			jedis.expire(key, seconds);
		}
	}
	/*public static String hget(String dbName,String key,String field) {
		return shardedJedis.get(dbName).hget(key, field);
	}*/
	public static String hget(String dbName, String key, String field) {
		try (Jedis jedis = shardedJedisPool.get(dbName).getResource()) {
			jedis.select(shardedWhich.get(dbName));
			return jedis.hget(key, field);
		}
	}
	
	public static Long hdel(String dbName,String key) {
		return shardedJedis.get(dbName).del(key);
	}
}
