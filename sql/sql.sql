CREATE TABLE `mono-dailyrewards` (
  `id` int(11) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `last_reward_day` int(11) NOT NULL,
  `num_rewards` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `mono-dailyrewards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
COMMIT;
