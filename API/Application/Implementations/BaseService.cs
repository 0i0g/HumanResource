using Application.Interfaces;
using Data_EF;
using System;
using System.Collections.Generic;
using System.Text;

namespace Application.Implementations
{
    public class BaseService
    {
        protected IUnitOfWork _unitOfWork;
        protected IAuthService _authService;

        public BaseService(IUnitOfWork unitOfWork, IAuthService authService)
        {
            _unitOfWork = unitOfWork;
            _authService = authService;
        }
    }
}
