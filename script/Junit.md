# JUNI tips

## Tips
@FixMethodOrder(MethodSorters.NAME_ASCENDING)



## ssh
			sshCli = new SSHClientImpl(
			        testConfig.getProperty("vUPG.0.SC"),
                    testConfig.getProperty("vUPG.0.user"),
                    testConfig.getProperty("vUPG.0.pwd"));


            testConfig.readUserProperties();
testConfig.getProperty(TestConfig.PROP_SUT_IP), TestConfig.DEFAULT_SUT_SSH_USERNAME, TestConfig.DEFAULT_SUT_SSH_PASSWORD)


## debug
    		if(logger.isDebugEnabled()){
				logger.debug("vUPG host:"+testConfig.getProperty("vUPG.0.SC"));
                logger.debug("vUPG user:"+testConfig.getProperty("vUPG.0.user"));
                logger.debug("vUPG pwd:"+testConfig.getProperty("vUPG.0.pwd"));
			}

## 