CREATE TABLE `tbl_user` (
  `tbl_user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tbl_user_name` varchar(45) NOT NULL,
  `tbl_user_password` varchar(45) NOT NULL,
  `tbl_user_create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tbl_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Table used to store user login information';
