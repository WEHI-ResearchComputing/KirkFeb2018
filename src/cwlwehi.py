'''
Created on 24Aug.,2017

@author: thomas.e
'''

import sys
import re
from toil.cwl.cwltoil import main

def registerDrmaaBatchSystem():
    from toil.batchSystems.registry import addBatchSystemFactory
    from toil.batchSystems.options import addOptionsDefinition
    
    def drmaaBatchSystemFactory():
        from wehi_pipeline.batchSystems.drmaaBatchSystem import DrmaaBatchSystem
        return DrmaaBatchSystem
    
    addBatchSystemFactory('drmaa', drmaaBatchSystemFactory)
        
    def addOptions(addOptionFn):
        addOptionFn("--jobQueue", dest="jobQueue", default=None,
                help=("A job queue (used by the DRMAA batch system)"))
        addOptionFn("--jobNamePrefix", dest="jobNamePrefix", default='toil',
                help=("A job name prefix (will be concatenated with the first part of the Toil workflowID, used by the DRMAA batch system)"))
        
    addOptionsDefinition(addOptions)

if __name__ == '__main__':
    registerDrmaaBatchSystem()
    sys.argv[0] = re.sub(r'(-script\.pyw?|\.exe)?$', '', sys.argv[0])
    sys.exit(main())


