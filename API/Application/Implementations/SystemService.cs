using Application.Interfaces;
using Application.RequestModels;
using Application.ViewModels;
using Data.Entities;
using Data_EF;
using Data_EF.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities.Constants;
using Utilities.Helper;

namespace Application.Implementations
{
    public class SystemService : BaseService, ISystemService
    {
        private ISystemRepository _systemRepository;
        private IEmailService _emailService;

        public SystemService(IUnitOfWork unitOfWork, IAuthService authService, IEmailService emailService) : base(unitOfWork, authService)
        {
            _systemRepository = unitOfWork.System;
            _emailService = emailService;
        }

        public async Task<ApiResponse> CreateSystem(CreateSystemModel model)
        {
            var user = _authService.User;
            if (!user.IsAdmin)
            {
                return ApiResponse.Forbidden();
            }

            if (_systemRepository.Contains(x => x.Code == model.Code && !x.IsDeleted))
            {
                return ApiResponse.BadRequest(SystemMessageConst.DuplicateCode);
            }

            _systemRepository.Add(new AppSystem
            {
                Id = Guid.NewGuid(),
                Name = model.Name,
                Code = model.Code
            });

            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> GetListSystem()
        {
            if (!_authService.User.IsAdmin)
            {
                return ApiResponse.Forbidden();
            }

            var listSystem = _systemRepository.GetMany(x => !x.IsDeleted)
                .Select(x => new SystemInformation
                {
                    Id = x.Id,
                    Code = x.Code,
                    Name = x.Name
                }).ToList();

            return ApiResponse.OK(listSystem);
        }

        public async Task<ApiResponse> Update(UpdateSystemModel model)
        {
            if (!_authService.User.IsAdmin)
            {
                return ApiResponse.Forbidden();
            }

            var system = _systemRepository.FirstOrDefault(x => x.Id == model.Id);

            if (system == null)
            {
                return ApiResponse.NotFound();
            }

            var isSystemCodeExisted = _systemRepository.Contains(x => x.Code == model.Code && x.Id != model.Id);
            if (isSystemCodeExisted)
            {
                return ApiResponse.BadRequest(SystemMessageConst.DuplicateCode);
            }

            system.Code = model.Code ??= system.Code;
            system.Name = model.Name ??= system.Name;
            system.IsDeleted = model.IsDeleted ??= system.IsDeleted;

            _systemRepository.Update(system);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

    }
}
